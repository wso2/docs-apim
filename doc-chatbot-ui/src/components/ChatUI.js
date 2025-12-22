/**
 * Copyright (c) 2023-2025, WSO2 LLC. (https://www.wso2.com).
 *
 * WSO2 LLC. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import React, { useEffect, useRef, useState } from 'react';
import MessageItem from './MessageItem';
import authService from '../api/authService';
import SendIcon from '@mui/icons-material/Send';
import KeyboardArrowDownIcon from '@mui/icons-material/KeyboardArrowDown';
import KeyboardArrowUpIcon from '@mui/icons-material/KeyboardArrowUp';
import DocAIbot from './DocAIbot';
import './DocAIbot.css';
import './ScrollToBottom.css';

export default function ChatUI() {
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState('');
  const [loading, setLoading] = useState(false);
  const [showScrollButton, setShowScrollButton] = useState(false);
  const [scrollDirection, setScrollDirection] = useState('down'); // 'up' or 'down'
  const listRef = useRef(null);
  const abortControllerRef = useRef(null);

  const suggestions = [
    "How do I create an API?",
    "How do I secure an API?",
    "How to subscribe to an API?",
  ];

  useEffect(() => {
    // Load messages from localStorage on initial render
    const savedMessages = localStorage.getItem('chatHistory');
    if (savedMessages) {
      setMessages(JSON.parse(savedMessages));
    }

    // Function to handle hash changes for clearing history
    const handleHashChange = () => {
      if (window.location.hash.startsWith('#clearHistory_')) {
        if (abortControllerRef.current) {
          abortControllerRef.current.abort();
        }
        localStorage.removeItem('chatHistory');
        setMessages([]);
        setLoading(false);
        // Optional: reload to reset the component state completely
        // window.location.reload(); 
      }
    };

    // Add event listener for hash changes
    window.addEventListener('hashchange', handleHashChange);

    // Cleanup the event listener on component unmount
    return () => {
      window.removeEventListener('hashchange', handleHashChange);
    };
  }, []); // Empty dependency array ensures this runs only once

  useEffect(() => {
    // Save messages to localStorage whenever they change
    if (messages.length > 0) {
      localStorage.setItem('chatHistory', JSON.stringify(messages));
    }
  }, [messages]);

  const handleScroll = () => {
    if (listRef.current) {
      const { scrollTop, scrollHeight, clientHeight } = listRef.current;
      const isAtBottom = scrollHeight - scrollTop <= clientHeight + 1; // +1 for tolerance
      const isAtTop = scrollTop <= 1; // Near the top
      
      if (isAtBottom) {
        setShowScrollButton(false);
        setScrollDirection('down');
      } else {
        setShowScrollButton(true);
        // If we're closer to the top, show down arrow; otherwise show up arrow
        const distanceFromTop = scrollTop;
        const distanceFromBottom = scrollHeight - scrollTop - clientHeight;
        
        if (distanceFromBottom > distanceFromTop) {
          setScrollDirection('down'); // Closer to top, show down to go to bottom
        } else {
          setScrollDirection('up'); // Closer to bottom, show up to go to top
        }
      }
    }
  };

  useEffect(() => {
    const listElement = listRef.current;
    if (listElement) {
      listElement.addEventListener('scroll', handleScroll);
      return () => listElement.removeEventListener('scroll', handleScroll);
    }
  }, []);

  const scrollToBottom = () => {
    if (listRef.current) {
      // prefer smooth behavior but fallback to instant for large jumps
      try {
        listRef.current.scrollTo({ top: listRef.current.scrollHeight, behavior: 'smooth' });
      } catch (e) {
        listRef.current.scrollTop = listRef.current.scrollHeight;
      }
    }
  };

  const scrollToTop = () => {
    if (listRef.current) {
      listRef.current.scrollTo({
        top: 0,
        behavior: 'smooth'
      });
    }
  };

  const handleScrollButtonClick = () => {
    if (scrollDirection === 'up') {
      scrollToTop();
    } else {
      scrollToBottom();
    }
  };

  async function sendMessage(text) {
    if (!text || !text.trim()) return;
    const msg = { id: Date.now(), from: 'user', text };
    setMessages(m => [...m, msg]);
    setInput('');
    setLoading(true);
    // When loading starts, scroll so the typing indicator (rendered below) is visible.
    // Slight delay ensures the typing indicator DOM node is present.
    setTimeout(() => {
      // Only auto-scroll if user is near bottom (so we don't yank them while reading history)
      try {
        const el = listRef.current;
        if (!el) return;
        const { scrollTop, scrollHeight, clientHeight } = el;
        const isNearBottom = (scrollHeight - scrollTop) <= (clientHeight + 120); // allow some tolerance
        if (isNearBottom) scrollToBottom();
      } catch (e) { }
    }, 80);

    abortControllerRef.current = new AbortController();
    const signal = abortControllerRef.current.signal;

    try {
      const token = await authService.getAccessToken();
      
      const headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'product': 'apim',
        'branch': '4_5_0'
      };
      
      if (token) {
        headers['Authorization'] = `Bearer ${token}`;
      }
      
      const response = await fetch('https://cors-anywhere.herokuapp.com/https://e95488c8-8511-4882-967f-ec3ae2a0f86f-dev.e1-us-east-azure.choreoapis.dev/docs-assistant-us/docs-assistant/v1/chat', {
        method: 'POST',
        headers,
        body: JSON.stringify({
          question_context: "User is asking about WSO2 documentation",
          questions: [text]
        }),
        signal
      });
      
      if (response.ok) {
        const data = await response.json();
        const content = data.content || data.answer || data.response || JSON.stringify(data);
        setMessages(m => [...m, { id: Date.now() + 1, from: 'bot', text: content }]);
        // after bot message appended, ensure view scrolls to it if user was near bottom
        setTimeout(() => {
          try {
            const el = listRef.current;
            if (!el) return;
            const { scrollTop, scrollHeight, clientHeight } = el;
            const isNearBottom = (scrollHeight - scrollTop) <= (clientHeight + 220);
            if (isNearBottom) scrollToBottom();
          } catch (e) { }
        }, 40);
      } else {
        setMessages(m => [...m, { id: Date.now() + 1, from: 'bot', text: 'Unable to get response. Please try again.' }]);
      }
    } catch (err) {
      if (err.name !== 'AbortError') {
        setMessages(m => [...m, { id: Date.now() + 2, from: 'bot', text: 'Unable to get response. Please try again.' }]);
      }
    } finally {
  setLoading(false);
  // ensure typing indicator disappears and content is visible
  setTimeout(() => { try { scrollToBottom(); } catch (e) {} }, 100);
      abortControllerRef.current = null;
    }
  }

  const handleSuggestionClick = (suggestion) => {
    sendMessage(suggestion);
  };

  return (
    <div className="chat-root">
      <div className="chat-card">
        {messages.length === 0 && (
          <>
            <DocAIbot />
            <div className="chat-header">
              <h1 className="chat-title">Hi, Welcome to API Manager Assistant!</h1>
              <p className="chat-subtitle">Get help with WSO2 API Manager docs and setup.</p>
            </div>
          </>
        )}
        <div className={`messages ${messages.length === 0 ? 'empty' : 'has-messages'}`} ref={listRef} onScroll={handleScroll}>
          {messages.length === 0 && (
            <div className="suggestions-wrap">
              {/* <p className="suggestion-header">Suggestions</p> */}
              <div className="suggestions">
                {suggestions.map((suggestion, index) => (
                  <div
                    key={index}
                    className="suggestion-pill"
                    onClick={() => handleSuggestionClick(suggestion)}
                  >
                    {suggestion}
                  </div>
                ))}
              </div>
            </div>
          )}
          {messages.map(m => (
            <MessageItem key={m.id} message={m} />
          ))}
          {loading && (
            <div className="msg bot typing-indicator">
              <div className="msg-content">
                <span />
                <span />
                <span />
              </div>
            </div>
          )}
          {showScrollButton && (
            <button className="scroll-to-bottom" onClick={handleScrollButtonClick}>
              {scrollDirection === 'up' ? (
                <KeyboardArrowUpIcon sx={{ fontSize: 16, color: 'rgba(0,0,0,0.65)' }} />
              ) : (
                <KeyboardArrowDownIcon sx={{ fontSize: 16, color: 'rgba(0,0,0,0.65)' }} />
              )}
            </button>
          )}
        </div>
        <form
          className="composer"
          onSubmit={e => {
            e.preventDefault();
            sendMessage(input);
          }}
        >
                    <input
            type="text"
            className="composer-input"
            value={input}
            onChange={(e) => setInput(e.target.value)}
            onKeyPress={(e) => e.key === 'Enter' && !loading && sendMessage(input)}
            placeholder="Ask our chatbot anything you don't know..."
            disabled={loading}
          />
          <button className="composer-send" onClick={() => sendMessage(input)} disabled={loading || !input.trim()}>
            {loading ? <div className="loader"></div> : <SendIcon sx={{transform: 'rotate(315deg)'}}/>}
          </button>
        </form>
        <p className="disclaimer">Use DocAi mindfully as AI can make mistakes.</p>
      </div>
    </div>
  );
}
