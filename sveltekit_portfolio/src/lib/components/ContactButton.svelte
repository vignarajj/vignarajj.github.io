<script lang="ts">
  export let icon: string;
  export let url: string;
  export let label: string;
  let hovered = false;
  function open() {
    window.open(url, '_blank', 'noopener');
  }
</script>

<div
  class="contact-btn"
  on:mouseenter={() => (hovered = true)}
  on:mouseleave={() => (hovered = false)}
  on:click={open}
  tabindex="0"
  role="button"
  aria-label={label}
  style="transform: scale({hovered ? 1.08 : 1});"
>
  <img src={icon} alt={label} class="icon" />
</div>

<style>
  .contact-btn {
    width: 56px;
    height: 56px;
    background: #23272f;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 4px 16px rgba(0,0,0,0.12);
    cursor: pointer;
    transition: transform 0.2s cubic-bezier(.4,2,.6,1), box-shadow 0.2s;
    border: 2px solid #444;
  }
  .contact-btn:focus {
    outline: 2px solid #6c63ff;
  }
  .icon {
    width: 32px;
    height: 32px;
    object-fit: contain;
    filter: brightness(1.2);
  }
</style> 