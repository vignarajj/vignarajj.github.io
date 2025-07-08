<script lang="ts">
  import EnhancedAnimatedText from '$lib/components/EnhancedAnimatedText.svelte';
  import AnimatedSection from '$lib/components/AnimatedSection.svelte';
  import { goto } from '$app/navigation';
</script>

<section class="home-section">
  <AnimatedSection>
    <h1 class="hero-title">
      <EnhancedAnimatedText text="Hi, I'm Vignaraj" animationType="shimmer" />
    </h1>
    <EnhancedAnimatedText text="Full Stack Developer & Tech Enthusiast" animationType="typewriter" delay={400} />
    <p class="intro">I build modern, animated, and high-performance web and mobile apps. Explore my skills, projects, and more below!</p>
  </AnimatedSection>
  <nav class="home-nav">
    <button on:click={() => goto('/skills')}>Skills</button>
    <button on:click={() => goto('/core-competency')}>Core Competency</button>
    <button on:click={() => goto('/chat')}>Chat</button>
    <button on:click={() => goto('/medium')}>Medium</button>
    <button on:click={() => goto('/contact')}>Contact</button>
  </nav>
</section>

<style>
  .home-section {
    max-width: 900px;
    margin: 0 auto;
    padding: 3rem 1rem 2rem 1rem;
    text-align: center;
  }
  .hero-title {
    font-size: 2.6rem;
    margin-bottom: 1.2rem;
    color: #6c63ff;
    font-weight: bold;
  }
  .intro {
    font-size: 1.2rem;
    color: #ccc;
    margin: 1.5rem 0 2.5rem 0;
  }
  .home-nav {
    display: flex;
    flex-wrap: wrap;
    gap: 1.2rem;
    justify-content: center;
    margin-top: 2rem;
  }
  .home-nav button {
    background: #6c63ff;
    color: #fff;
    border: none;
    border-radius: 12px;
    padding: 0.9rem 2.2rem;
    font-size: 1.1rem;
    font-weight: 600;
    cursor: pointer;
    transition: background 0.2s;
  }
  .home-nav button:hover {
    background: #5548c8;
  }
</style>
