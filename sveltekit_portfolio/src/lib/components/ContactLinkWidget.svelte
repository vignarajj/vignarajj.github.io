<script lang="ts">
  export let onClick: (() => void) | null = null;
  let hovered = false;
</script>

<div class="contact-link-container">
  <button
    class="contact-link-btn"
    on:mouseenter={() => (hovered = true)}
    on:mouseleave={() => (hovered = false)}
    on:click={() => onClick && onClick()}
    style="transform: scale({hovered ? 1.05 : 1});"
  >
    <slot>Get in Touch</slot>
  </button>
</div>

<style>
  .contact-link-container {
    padding: 20px 16px;
    display: flex;
    justify-content: center;
  }
  .contact-link-btn {
    background: linear-gradient(90deg, #6c63ff 60%, #23272f 100%);
    border-radius: 20px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.08);
    border: none;
    color: #fff;
    font-size: 1.1rem;
    font-weight: bold;
    padding: 12px 32px;
    cursor: pointer;
    transition: transform 0.2s cubic-bezier(.4,2,.6,1), box-shadow 0.2s;
    outline: none;
  }
  .contact-link-btn:focus {
    outline: 2px solid #6c63ff;
  }
</style> 