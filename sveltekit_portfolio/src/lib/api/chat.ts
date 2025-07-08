/**
 * Send a chat message to the backend AI/chatbot API.
 * @param message User's message
 * @returns Promise resolving to bot response string
 */
export async function sendChatMessage(message: string): Promise<string> {
  try {
    const res = await fetch('https://your-backend-api/chat', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ message }),
    });
    if (!res.ok) throw new Error('Failed to send chat message');
    const data = await res.json();
    return data.reply || 'No response from bot.';
  } catch (err) {
    return 'Error: ' + (err as Error).message;
  }
} 