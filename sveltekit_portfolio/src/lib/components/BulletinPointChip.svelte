<script lang="ts">
  export let text: string;
  export let onClick: (() => void) | null = null;
  export let isNavigable: boolean = false;

  let hovered = false;
</script>

<div
  class="chip-container {isNavigable ? 'navigable' : ''}"
  on:mouseenter={() => (hovered = true)}
  on:mouseleave={() => (hovered = false)}
  on:click={() => isNavigable && onClick && onClick()}
  style="transform: scale({hovered ? 1.05 : 1});"
  tabindex={isNavigable ? 0 : undefined}
  role={isNavigable ? 'button' : undefined}
>
  <span class="chip-icon">✔</span>
  <span class="chip-label">{text}</span>
</div>

<style>
  .chip-container {
    display: inline-flex;
    align-items: center;
    background: linear-gradient(90deg, #6c63ff 80%, #6c63ff14 100%);
    border-radius: 20px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.08);
    padding: 4px 12px 4px 8px;
    margin: 4px;
    cursor: pointer;
    transition: transform 0.2s cubic-bezier(.4,2,.6,1), box-shadow 0.2s;
    color: #fff;
    font-size: 1rem;
    user-select: none;
  }
  .chip-container.navigable:focus {
    outline: 2px solid #6c63ff;
  }
  .chip-icon {
    margin-right: 4px;
    font-size: 1.1em;
  }
  .chip-label {
    font-weight: 500;
    letter-spacing: 0.02em;
  }
</style> 