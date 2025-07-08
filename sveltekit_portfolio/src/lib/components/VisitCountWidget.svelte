<script lang="ts">
  import { tweened } from 'svelte/motion';
  import { onMount } from 'svelte';
  export let visitCount: number = 0;
  const animatedCount = tweened(0, { duration: 2000 });
  onMount(() => {
    animatedCount.set(visitCount);
  });
</script>

<span class="visit-count">
  Site Visits: {$animatedCount | 0}
</span>

<style>
  .visit-count {
    font-size: 1rem;
    color: #fff;
    font-weight: 500;
    letter-spacing: 0.02em;
    background: #23272f;
    border-radius: 12px;
    padding: 6px 16px;
    margin: 8px 0;
    display: inline-block;
  }
</style> 