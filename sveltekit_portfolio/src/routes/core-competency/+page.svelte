<script lang="ts">
  import { coreCompetencies } from '$lib/stores/core-competency.store';
  import AnimatedSection from '$lib/components/AnimatedSection.svelte';
  import { onMount } from 'svelte';
  import type { CoreCompetency } from '$lib/models/core-competency.model';
  import { get } from 'svelte/store';

  // Example: Populate coreCompetencies store on mount (replace with real data/API)
  onMount(() => {
    if (get(coreCompetencies).length === 0) {
      coreCompetencies.set([
        { title: 'Problem Solving', description: 'Expert at breaking down complex problems and finding efficient solutions.' },
        { title: 'Team Leadership', description: 'Experienced in leading cross-functional teams to deliver high-quality products.' },
        { title: 'Communication', description: 'Clear and effective communicator with technical and non-technical stakeholders.' },
      ]);
    }
  });
</script>

<section class="core-section">
  <h1>Core Competencies</h1>
  <div class="core-list">
    {#if $coreCompetencies.length === 0}
      <p>Loading core competencies...</p>
    {:else}
      {#each $coreCompetencies as competency (competency.title)}
        <AnimatedSection>
          <div class="core-item">
            <h2>{competency.title}</h2>
            <p>{competency.description}</p>
          </div>
        </AnimatedSection>
      {/each}
    {/if}
  </div>
</section>

<style>
  .core-section {
    max-width: 900px;
    margin: 0 auto;
    padding: 2rem 1rem;
    text-align: center;
  }
  .core-list {
    display: flex;
    flex-wrap: wrap;
    gap: 2rem;
    justify-content: center;
    margin-top: 2rem;
  }
  .core-item {
    background: #23272f;
    border-radius: 16px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.08);
    padding: 1.5rem 2rem;
    min-width: 220px;
    max-width: 320px;
    color: #fff;
    text-align: left;
  }
  h1 {
    font-size: 2.2rem;
    margin-bottom: 1.5rem;
    color: #6c63ff;
  }
  h2 {
    font-size: 1.2rem;
    margin-bottom: 0.5rem;
    color: #fff;
  }
  p {
    font-size: 1rem;
    color: #ccc;
  }
</style> 