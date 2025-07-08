<script lang="ts">
  import { mediumPosts, mediumPostsLoading } from '$lib/stores/medium-posts.store';
  import AnimatedSection from '$lib/components/AnimatedSection.svelte';
  import { onMount } from 'svelte';
  import { fetchMediumPosts } from '$lib/api/medium';

  let error = '';

  onMount(async () => {
    mediumPostsLoading.set(true);
    error = '';
    try {
      const posts = await fetchMediumPosts();
      mediumPosts.set(posts);
    } catch (err) {
      error = (err as Error).message || 'Failed to fetch Medium posts.';
      mediumPosts.set([]);
    } finally {
      mediumPostsLoading.set(false);
    }
  });
</script>

<section class="medium-section">
  <h1>Medium Stories</h1>
  <div class="medium-list">
    {#if $mediumPostsLoading}
      <p>Loading Medium posts...</p>
    {:else if error}
      <p class="error">{error}</p>
    {:else if $mediumPosts.length === 0}
      <p>No Medium posts found.</p>
    {:else}
      {#each $mediumPosts as post (post.title)}
        <AnimatedSection>
          <a href={post.link} target="_blank" rel="noopener" class="medium-post">
            <h2>{post.title}</h2>
            <p>{post.pubDate?.toLocaleDateString()}</p>
          </a>
        </AnimatedSection>
      {/each}
    {/if}
  </div>
</section>

<style>
  .medium-section {
    max-width: 900px;
    margin: 0 auto;
    padding: 2rem 1rem;
    text-align: center;
  }
  .medium-list {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
    align-items: center;
    margin-top: 2rem;
  }
  .medium-post {
    background: #23272f;
    border-radius: 16px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.08);
    padding: 1.5rem 2rem;
    min-width: 220px;
    max-width: 520px;
    color: #fff;
    text-align: left;
    text-decoration: none;
    transition: background 0.2s;
  }
  .medium-post:hover {
    background: #6c63ff;
    color: #fff;
  }
  .error {
    color: #ff6b6b;
    font-size: 1rem;
    margin: 1rem 0;
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