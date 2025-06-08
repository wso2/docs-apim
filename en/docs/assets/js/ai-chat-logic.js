async function sendMessage() {
    const input = document.getElementById("user-input");
    const chat = document.getElementById("chat-history");
    const button = document.getElementById("submit-button");
    const userMessage = input.value.trim();
    if (!userMessage) return;

    const userDiv = document.createElement("div");
    userDiv.className = "message user";
    userDiv.textContent = userMessage;
    chat.appendChild(userDiv);

    input.value = "";
    input.disabled = true;
    button.disabled = true;
    chat.scrollTop = chat.scrollHeight;

    try {

      const response = await fetch("API_URL", {
          method: 'POST',
          headers: {
              'accept': 'text/event-stream',
              'Content-Type': 'application/json'
          },
          body: JSON.stringify({
              questions: [userMessage],
              question_context: ""
          })
      });

      if (!response.ok) {
          const errorBody = await response.text();
          throw new Error(`HTTP error! Status: ${response.status}. Response: ${errorBody}`);
      }

      const reader = response.body.getReader();
      const decoder = new TextDecoder('utf-8');
      let rawMarkdown = '';

      const aiDiv = document.createElement("div");
      aiDiv.className = "message ai";
      aiDiv.innerHTML = "";

      chat.appendChild(aiDiv);
      chat.scrollTop = chat.scrollHeight;

      while (true) {
        const { done, value } = await reader.read();
        if (done) break;

        const chunk = decoder.decode(value, { stream: true });
        rawMarkdown += chunk; 

        aiDiv.innerHTML = marked.parse(rawMarkdown);

        chat.scrollTop = chat.scrollHeight;
      }   

    } catch (err) {
      const errorDiv = document.createElement("div");
      errorDiv.className = "message ai";
      errorDiv.textContent = "An error occurred, please try again later";
      chat.appendChild(errorDiv);
    } finally {
        input.disabled = false;
        button.disabled = false;
    }

  }