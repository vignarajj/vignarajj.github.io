<script lang="ts">
  import { theme, toggleTheme } from '$lib/stores/theme.store';
  import { browser } from '$app/environment';
  let currentTheme: 'light' | 'dark' = 'light';
  $: currentTheme = $theme;
  $: if (browser) {
    document.body.classList.remove(currentTheme === 'light' ? 'dark' : 'light');
    document.body.classList.add(currentTheme);
  }
</script>

<header class="app-bar">
  <button class="app-title" aria-label="Go to home" on:click={() => window.location.href = '/'}>
    Vignaraj Portfolio
  </button>
  <button class="theme-toggle" on:click={toggleTheme} aria-label="Toggle theme">
    {#if $theme === 'light'}🌞{:else}🌙{/if}
  </button>
</header>
<main>
  <slot />
</main>

<style>
  .app-bar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 1rem 2rem;
    background: var(--app-bar-bg, #fff);
    color: var(--app-bar-fg, #23272f);
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
    position: sticky;
    top: 0;
    z-index: 10;
  }
  .app-title {
    font-size: 1.3rem;
    font-weight: bold;
    letter-spacing: 0.04em;
    cursor: pointer;
    background: none;
    border: none;
    color: inherit;
    padding: 0;
    margin: 0;
    outline: none;
  }
  .theme-toggle {
    background: none;
    border: none;
    font-size: 1.5rem;
    cursor: pointer;
    color: inherit;
    outline: none;
    transition: color 0.2s;
  }
  main {
    min-height: 80vh;
    background: var(--main-bg, #f7f7fa);
    color: var(--main-fg, #23272f);
    transition: background 0.2s, color 0.2s;
  }
  :global(body.light) {
    --app-bar-bg: #fff;
    --app-bar-fg: #23272f;
    --main-bg: #f7f7fa;
    --main-fg: #23272f;
  }
  :global(body.dark) {
    --app-bar-bg: #23272f;
    --app-bar-fg: #fff;
    --main-bg: #181a20;
    --main-fg: #fff;
  }
</style> 