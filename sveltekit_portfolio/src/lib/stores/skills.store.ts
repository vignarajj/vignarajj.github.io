import { writable } from 'svelte/store';
import type { Skill } from '../models/skill.model';

// Store for the list of skills
export const skills = writable<Skill[]>([]); 