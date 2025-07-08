<script lang="ts">
  import { chatMessages, chatInput, chatLoading } from '$lib/stores/chat.store';
  import AnimatedSection from '$lib/components/AnimatedSection.svelte';
  import { sendChatMessage } from '$lib/api/chat';

  async function sendMessage() {
    if ($chatInput.trim() === '') return;
    chatMessages.update((msgs) => [
      ...msgs,
      { sender: 'user', message: $chatInput, timestamp: new Date() }
    ]);
    chatInput.set('');
    chatLoading.set(true);
    try {
      const reply = await sendChatMessage($chatInput);
      chatMessages.update((msgs) => [
        ...msgs,
        { sender: 'bot', message: reply, timestamp: new Date() }
      ]);
    } catch (err) {
      chatMessages.update((msgs) => [
        ...msgs,
        { sender: 'bot', message: 'Error: ' + (err as Error).message, timestamp: new Date() }
      ]);
    } finally {
      chatLoading.set(false);
    }
  }
</script>

<section class="chat-section">
  <h1>Chat</h1>
  <div class="chat-messages">
    {#each $chatMessages as msg, i (msg.timestamp)}
      <AnimatedSection delay={i * 100}>
        <div class="chat-msg {msg.sender}">
          <span class="sender">{msg.sender === 'user' ? 'You' : 'Bot'}:</span>
          <span class="msg">{msg.message}</span>
        </div>
      </AnimatedSection>
    {/each}
    {#if $chatLoading}
      <div class="chat-msg bot loading">Bot is typing...</div>
    {/if}
  </div>
  <div class="chat-input-row">
    <input
      type="text"
      bind:value={$chatInput}
      placeholder="Type your message..."
      on:keydown={(e) => e.key === 'Enter' && sendMessage()}
      class="chat-input"
    />
    <button on:click={sendMessage} class="send-btn">Send</button>
  </div>
</section>

<style>
  .chat-section {
    max-width: 600px;
    margin: 0 auto;
    padding: 2rem 1rem;
    text-align: center;
  }
  .chat-messages {
    min-height: 200px;
    margin-bottom: 1.5rem;
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
  .chat-msg {
    padding: 0.7rem 1.2rem;
    border-radius: 16px;
    background: #23272f;
    color: #fff;
    text-align: left;
    max-width: 80%;
    margin: 0 auto;
    font-size: 1rem;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
  }
  .chat-msg.user {
    background: #6c63ff;
    color: #fff;
    align-self: flex-end;
  }
  .chat-msg.bot {
    background: #23272f;
    color: #fff;
    align-self: flex-start;
  }
  .chat-msg.loading {
    font-style: italic;
    opacity: 0.7;
  }
  .chat-input-row {
    display: flex;
    gap: 0.5rem;
    justify-content: center;
    align-items: center;
  }
  .chat-input {
    flex: 1;
    padding: 0.7rem 1rem;
    border-radius: 16px;
    border: 1px solid #6c63ff;
    font-size: 1rem;
    outline: none;
  }
  .send-btn {
    background: #6c63ff;
    color: #fff;
    border: none;
    border-radius: 16px;
    padding: 0.7rem 1.5rem;
    font-size: 1rem;
    cursor: pointer;
    transition: background 0.2s;
  }
  .send-btn:hover {
    background: #5548c8;
  }
</style> 