# Ask the APIM AI Doc Assistant!

<div id="ai-chat">
  <div class="chat-container" id="chat-history">

  </div>

  <div class="input-container">
    <input id="user-input" type="text" placeholder="Ask something..." onkeydown="if(event.key==='Enter')sendMessage()"/>
    <button type="submit" id="submit-button" class="material-symbols-rounded" onclick="sendMessage()">
        <span class="material-symbols-outlined">send</span>
    </button>
  </div>
</div>

<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
