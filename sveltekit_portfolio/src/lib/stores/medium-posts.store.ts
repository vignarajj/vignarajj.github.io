import { writable } from 'svelte/store';
import type { MediumPost } from '../models/medium-post.model';

// Store for the list of Medium posts
export const mediumPosts = writable<MediumPost[]>([]);

// Store for loading state
export const mediumPostsLoading = writable<boolean>(false); 