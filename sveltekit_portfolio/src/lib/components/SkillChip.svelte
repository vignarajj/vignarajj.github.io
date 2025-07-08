<script lang="ts">
  import type { Skill } from '../models/skill.model';
  export let skill: Skill;
  export let onTap: (() => void) | null = null;
  let hovered = false;
</script>

<div
  class="skill-chip"
  on:mouseenter={() => (hovered = true)}
  on:mouseleave={() => (hovered = false)}
  on:click={() => onTap && onTap()}
  style="transform: scale({hovered ? 1.05 : 1});"
  tabindex="0"
  role="button"
>
  <img src={skill.iconPath} alt={skill.name} class="chip-avatar" />
  <span class="chip-label">{skill.name}</span>
</div>

<style>
  .skill-chip {
    display: inline-flex;
    align-items: center;
    background: #23272f;
    border-radius: 20px;
    border: 1px solid #444;
    box-shadow: 0 4px 8px rgba(0,0,0,0.08);
    padding: 4px 12px 4px 8px;
    margin: 4px;
    cursor: pointer;
    transition: transform 0.2s cubic-bezier(.4,2,.6,1), box-shadow 0.2s;
    color: #fff;
    font-size: 1rem;
    user-select: none;
  }
  .chip-avatar {
    width: 20px;
    height: 20px;
    margin-right: 6px;
    object-fit: contain;
    filter: brightness(1.2);
  }
  .chip-label {
    font-weight: 600;
    letter-spacing: 0.03em;
    font-size: 1rem;
  }
</style> 