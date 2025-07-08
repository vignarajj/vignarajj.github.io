import type { ContactModel } from '../models/contact.model';

/**
 * Send contact form data to the backend API.
 * @param data Contact form data
 * @returns Promise resolving to API response
 */
export async function sendContactForm(data: ContactModel): Promise<{ success: boolean; message: string }> {
  try {
    const res = await fetch('https://your-backend-api/contact', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data),
    });
    if (!res.ok) throw new Error('Failed to send contact form');
    return await res.json();
  } catch (err) {
    return { success: false, message: (err as Error).message };
  }
} 