<script lang="ts">
  import { onMount } from 'svelte';
  import { gsap } from 'gsap';

  export let delay: number = 0;
  let sectionEl: HTMLElement;

  onMount(() => {
    gsap.fromTo(
      sectionEl,
      { opacity: 0, y: window.innerWidth < 600 ? 40 : 60, scale: 0.9 },
      {
        opacity: 1,
        y: 0,
        scale: 1,
        duration: 0.6,
        delay: delay / 1000,
        ease: 'power3.out',
      }
    );
  });
</script>

<div bind:this={sectionEl}>
  <slot />
</div>

<style>
  div {
    will-change: opacity, transform;
  }
</style> 