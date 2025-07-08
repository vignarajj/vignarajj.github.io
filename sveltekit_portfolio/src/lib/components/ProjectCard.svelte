<script lang="ts">
  import type { Project } from './Project';
  export let project: Project;
  let hovered = false;
  function open() {
    window.open(project.url, '_blank', 'noopener');
  }
</script>

<div
  class="project-card"
  on:mouseenter={() => (hovered = true)}
  on:mouseleave={() => (hovered = false)}
  on:click={open}
  style="transform: scale({hovered ? 1.05 : 1});"
  tabindex="0"
  role="button"
>
  <div class="project-title">{project.title}</div>
  <div class="project-desc">{project.description}</div>
  <div class="project-link">Visit</div>
</div>

<style>
  .project-card {
    background: linear-gradient(120deg, #23272f 80%, #23272f14 100%);
    border-radius: 12px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.08);
    padding: 16px 12px;
    margin: 8px;
    width: min(300px, 60vw);
    min-width: 180px;
    color: #fff;
    cursor: pointer;
    transition: transform 0.2s cubic-bezier(.4,2,.6,1), box-shadow 0.2s;
    display: flex;
    flex-direction: column;
    gap: 4px;
  }
  .project-title {
    font-size: 1.1rem;
    font-weight: bold;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
  .project-desc {
    font-size: 0.95rem;
    color: #ccc;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
  }
  .project-link {
    color: #fff;
    text-decoration: underline;
    font-size: 1rem;
    margin-top: 2px;
  }
</style> 