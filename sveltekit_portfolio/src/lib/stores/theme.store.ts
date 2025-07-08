import { writable } from 'svelte/store';

export type Theme = 'light' | 'dark';

export const theme = writable<Theme>('light');

export function toggleTheme() {
  theme.update((t) => (t === 'light' ? 'dark' : 'light'));
} 