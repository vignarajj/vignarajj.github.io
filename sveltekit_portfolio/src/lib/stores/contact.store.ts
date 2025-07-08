import { writable } from 'svelte/store';
import type { ContactModel } from '../models/contact.model';

// Store for contact form data
export const contactForm = writable<ContactModel | null>(null);

// Store for contact form submission/loading state
export const contactSubmitting = writable<boolean>(false);

// Store for contact form submission result
export const contactResult = writable<string | null>(null); 