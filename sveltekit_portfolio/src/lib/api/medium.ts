import type { MediumPost } from '../models/medium-post.model';

/**
 * Fetch Medium posts from RSS or API.
 * @returns Promise resolving to an array of MediumPost
 */
export async function fetchMediumPosts(): Promise<MediumPost[]> {
  try {
    const res = await fetch('https://your-backend-api/medium');
    if (!res.ok) throw new Error('Failed to fetch Medium posts');
    return await res.json();
  } catch (err) {
    return [];
  }
} 