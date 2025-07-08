<script lang="ts">
  import { skills } from '$lib/stores/skills.store';
  import SkillChip from '$lib/components/SkillChip.svelte';
  import AnimatedSection from '$lib/components/AnimatedSection.svelte';
  import { onMount } from 'svelte';
  import type { Skill } from '$lib/models/skill.model';
  import { get } from 'svelte/store';

  // Example: Populate skills store on mount (replace with real data/API)
  onMount(() => {
    if (get(skills).length === 0) {
      skills.set([
        { name: 'Flutter', description: 'Cross-platform UI toolkit', proficiency: 0.9, iconPath: '/src/lib/assets/images/flutter.svg' },
        { name: 'Svelte', description: 'Reactive web framework', proficiency: 0.8, iconPath: '/src/lib/assets/images/javascript.svg' },
        { name: 'Dart', description: 'Programming language', proficiency: 0.85, iconPath: '/src/lib/assets/images/dart.svg' },
      ]);
    }
  });
</script>

<section class="skills-section">
  <h1>Skills</h1>
  <div class="skills-list">
    {#if $skills.length === 0}
      <p>Loading skills...</p>
    {:else}
      {#each $skills as skill (skill.name)}
        <AnimatedSection>
          <SkillChip {skill} onTap={() => {}} />
        </AnimatedSection>
      {/each}
    {/if}
  </div>
</section>

<style>
  .skills-section {
    max-width: 900px;
    margin: 0 auto;
    padding: 2rem 1rem;
    text-align: center;
  }
  .skills-list {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    justify-content: center;
    margin-top: 2rem;
  }
  h1 {
    font-size: 2.2rem;
    margin-bottom: 1.5rem;
    color: #6c63ff;
  }
</style> 