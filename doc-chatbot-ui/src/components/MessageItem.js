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

import React from 'react';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import './MessageItem.css';
import ThumbUpOffAltIcon from '@mui/icons-material/ThumbUpOffAlt';
import ThumbDownOffAltIcon from '@mui/icons-material/ThumbDownOffAlt';
import { useState, useEffect, useRef } from 'react';

export default function MessageItem({ message }) {
  const cls = message.from === 'user' ? 'msg user' : 'msg bot';
  
  const [feedback, setFeedback] = useState(null);
  const [comment, setComment] = useState('');
  const [showCommentBox, setShowCommentBox] = useState(false);
  const [feedbackSubmitted, setFeedbackSubmitted] = useState(false);
  const commentBoxRef = useRef(null);

  // Load feedback status from localStorage on mount
  useEffect(() => {
    if (message.id) {
      const saved = localStorage.getItem(`feedback_${message.id}`);
      if (saved) {
        try {
          const feedbackData = JSON.parse(saved);
          setFeedback(feedbackData.type);
          setFeedbackSubmitted(feedbackData.submitted);
        } catch (e) {
          console.error('Error loading feedback:', e);
        }
      }
    }
  }, [message.id]);

  useEffect(() => {
    if (showCommentBox) {
      commentBoxRef.current?.scrollIntoView({ behavior: 'smooth' });
    }
  }, [showCommentBox]);

  const handleFeedback = (newFeedback) => {
    // Don't allow changing feedback after submission
    if (feedbackSubmitted) {
      return;
    }
    
    setFeedback(currentFeedback => {
      const newValue = currentFeedback === newFeedback ? null : newFeedback;
      setShowCommentBox(newValue !== null);
      if (newValue === null) {
        setComment('');
      }
      return newValue;
    });
  };

  const handleCommentSubmit = () => {
    // Save feedback to localStorage
    const feedbackData = {
      submitted: true,
      type: feedback,
      comment: comment,
      timestamp: new Date().toISOString()
    };
    localStorage.setItem(`feedback_${message.id}`, JSON.stringify(feedbackData));
    
    // Here you can send the feedback and comment to your backend
    // You can add API call here to save the feedback
    
    // Close the comment box and mark as submitted
    setShowCommentBox(false);
    setFeedbackSubmitted(true);
    alert('Thank you for your feedback!');
  };
  
  return (
    <div className={cls} aria-live="polite">
      <div className="msg-content">
        {message.from === 'bot' ? (
          <>
            <ReactMarkdown 
              remarkPlugins={[remarkGfm]}
              components={{
                // Customize how different markdown elements are rendered
                h1: ({children}) => <h1 style={{fontSize: '1.5em', marginBottom: '0.5em', color: '#2c3e50'}}>{children}</h1>,
                h2: ({children}) => <h2 style={{fontSize: '1.3em', marginBottom: '0.4em', color: '#34495e'}}>{children}</h2>,
                h3: ({children}) => <h3 style={{fontSize: '1.1em', marginBottom: '0.3em', color: '#34495e'}}>{children}</h3>,
                p: ({children}) => <p style={{marginBottom: '0.8em', lineHeight: '1.6'}}>{children}</p>,
                ul: ({children}) => <ul style={{marginBottom: '0.8em', paddingLeft: '1.5em'}}>{children}</ul>,
                ol: ({children}) => <ol style={{marginBottom: '0.8em', paddingLeft: '1.5em'}}>{children}</ol>,
                li: ({children}) => <li style={{marginBottom: '0.3em'}}>{children}</li>,
                code: ({children, className}) => {
                  const isBlock = className?.includes('language-');
                  return isBlock ? (
                    <pre style={{
                      backgroundColor: '#f8f9fa', 
                      padding: '1em', 
                      borderRadius: '6px', 
                      overflow: 'auto',
                      marginBottom: '0.8em',
                      border: '1px solid #e9ecef'
                    }}>
                      <code>{children}</code>
                    </pre>
                  ) : (
                    <code style={{
                      backgroundColor: '#f8f9fa', 
                      padding: '0.2em 0.4em', 
                      borderRadius: '3px',
                      fontSize: '0.9em'
                    }}>{children}</code>
                  );
                },
                blockquote: ({children}) => (
                  <blockquote style={{
                    borderLeft: '4px solid #3498db',
                    paddingLeft: '1em',
                    margin: '0.8em 0',
                    fontStyle: 'italic',
                    backgroundColor: '#f8f9fa'
                  }}>
                    {children}
                  </blockquote>
                ),
                strong: ({children}) => <strong style={{fontWeight: '600'}}>{children}</strong>,
                em: ({children}) => <em style={{fontStyle: 'italic'}}>{children}</em>,
                a: ({children, href}) => (
                  <a href={href} target="_blank" rel="noopener noreferrer" style={{
                    color: '#3498db',
                    textDecoration: 'none'
                  }}>
                    {children}
                  </a>
                ),
                hr: () => <hr style={{margin: '1.5em 0', border: 'none', borderTop: '1px solid #e9ecef'}} />
              }}
            >
              {message.text}
            </ReactMarkdown>
            <div className="feedback-section">
              <button 
                onClick={() => handleFeedback('up')} 
                className={`feedback-btn ${feedback === 'up' ? 'selected' : ''}`}
                aria-label="Good response"
                disabled={feedbackSubmitted}
              >
                <ThumbUpOffAltIcon />
              </button>
              <button 
                onClick={() => handleFeedback('down')} 
                className={`feedback-btn ${feedback === 'down' ? 'selected' : ''}`}
                aria-label="Bad response"
                disabled={feedbackSubmitted}
              >
                <ThumbDownOffAltIcon />
              </button>
            </div>
            
            {showCommentBox && (
              <div className="feedback-comment-box" ref={commentBoxRef}>
                <p className="feedback-comment-title">
                  Share your feedback for this rating
                </p>
                <textarea
                  className="feedback-comment-input"
                  placeholder={
                    feedback === 'up'
                      ? 'What did you like about this response?'
                      : feedback === 'down'
                      ? 'What was the issue?'
                      : 'How can we improve this response?'
                  }
                  value={comment}
                  onChange={(e) => setComment(e.target.value)}
                  rows={3}
                />
                <button 
                  className="feedback-submit-btn"
                  onClick={handleCommentSubmit}
                  disabled={!comment.trim()}
                >
                  Submit
                </button>
              </div>
            )}
          </>
        ) : (
          message.text
        )}
      </div>
    </div>
  );
}
