<script lang="ts">
  import { onMount } from 'svelte';
  import { gsap } from 'gsap';
  export let text: string = '';
  export let style: string = '';
  export let delay: number = 0;
  export let animationType: 'fadeSlide' | 'typewriter' | 'shimmer' | 'glow' | 'bounce' | 'slide' = 'fadeSlide';
  let el: HTMLElement;

  onMount(() => {
    if (animationType === 'fadeSlide') {
      gsap.fromTo(
        el,
        { opacity: 0, y: 30 },
        { opacity: 1, y: 0, duration: 0.8, delay: delay / 1000, ease: 'power3.out' }
      );
    } else if (animationType === 'slide') {
      gsap.fromTo(
        el,
        { x: -40, opacity: 0 },
        { x: 0, opacity: 1, duration: 0.8, delay: delay / 1000, ease: 'power3.out' }
      );
    } else if (animationType === 'typewriter') {
      el.textContent = '';
      let i = 0;
      const chars = text.split('');
      function type() {
        if (i < chars.length) {
          el.textContent += chars[i++];
          setTimeout(type, 40);
        }
      }
      setTimeout(type, delay);
    } else if (animationType === 'shimmer') {
      gsap.fromTo(
        el,
        { opacity: 0.5 },
        { opacity: 1, duration: 1.5, repeat: -1, yoyo: true, ease: 'sine.inOut' }
      );
    }
  });
</script>

<span bind:this={el} style={style}>{animationType !== 'typewriter' ? text : ''}</span>

<style>
  span {
    display: inline-block;
    font-weight: 600;
    font-size: 1.1em;
    letter-spacing: 0.01em;
    color: #fff;
    white-space: pre-line;
  }
</style> 