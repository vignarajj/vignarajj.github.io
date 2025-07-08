<script lang="ts">
  import ProjectCard from './ProjectCard.svelte';
  import type { Project } from './Project';
  export let projects: Project[] = [];
  export let cardWidth: number = 300;
  let currentIndex = 0;
  let scrollEl: HTMLDivElement;

  function scrollToIndex(index: number) {
    if (scrollEl) {
      scrollEl.scrollTo({
        left: index * (cardWidth + 16),
        behavior: 'smooth',
      });
      currentIndex = index;
    }
  }

  function onScroll() {
    if (scrollEl) {
      const idx = Math.round(scrollEl.scrollLeft / (cardWidth + 16));
      if (idx !== currentIndex) currentIndex = idx;
    }
  }
</script>

{#if projects.length === 0 || cardWidth <= 0}
  <div class="no-projects">No projects available</div>
{:else}
  <div class="marquee-container">
    <div
      class="marquee-scroll"
      bind:this={scrollEl}
      on:scroll={onScroll}
      style="height: 180px;"
    >
      {#each projects as project, i}
        <div class="marquee-card" style="width: {cardWidth}px;">
          <ProjectCard {project} />
        </div>
      {/each}
    </div>
    {#if projects.length >= 5}
      <div class="marquee-indicators">
        {#each projects as _, i}
          <span
            class="indicator {i === currentIndex ? 'active' : ''}"
            on:click={() => scrollToIndex(i)}
          ></span>
        {/each}
      </div>
    {/if}
  </div>
{/if}

<style>
  .marquee-container {
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  .marquee-scroll {
    display: flex;
    flex-direction: row;
    overflow-x: auto;
    scroll-behavior: smooth;
    gap: 16px;
    padding: 0 16px;
    height: 180px;
    align-items: center;
  }
  .marquee-card {
    flex: 0 0 auto;
    margin: 0 8px;
  }
  .marquee-indicators {
    display: flex;
    justify-content: center;
    margin-top: 8px;
    gap: 8px;
  }
  .indicator {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    background: #6c63ff44;
    cursor: pointer;
    transition: background 0.2s;
  }
  .indicator.active {
    background: #6c63ff;
    width: 14px;
    height: 14px;
  }
  .no-projects {
    color: #aaa;
    font-size: 1rem;
    padding: 16px;
  }
</style> 