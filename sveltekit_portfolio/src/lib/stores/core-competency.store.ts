import { writable } from 'svelte/store';
import type { CoreCompetency } from '../models/core-competency.model';

// Store for the list of core competencies
export const coreCompetencies = writable<CoreCompetency[]>([]); 