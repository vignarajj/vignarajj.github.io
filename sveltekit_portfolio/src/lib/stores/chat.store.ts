import { writable } from 'svelte/store';

export interface ChatMessage {
  sender: 'user' | 'bot';
  message: string;
  timestamp: Date;
}

// Store for chat messages
export const chatMessages = writable<ChatMessage[]>([]);

// Store for current user input
export const chatInput = writable<string>('');

// Store for loading state (e.g., waiting for bot response)
export const chatLoading = writable<boolean>(false); 