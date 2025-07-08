import { writable } from 'svelte/store';
import type { FlutterPlugin } from '../models/flutter-plugin.model';

// Store for the list of Flutter plugins
export const flutterPlugins = writable<FlutterPlugin[]>([]); 