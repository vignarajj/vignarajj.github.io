<script lang="ts">
  export let url: string = 'https://calendly.com/vignarajj';
</script>

<div class="calendly-container">
  <iframe
    src={url}
    title="Calendly Scheduling"
    frameborder="0"
    style="width: 100%; height: 100%; min-height: 400px; border: none;"
    allowfullscreen
  ></iframe>
</div>

<style>
  .calendly-container {
    width: 100%;
    min-height: 400px;
    height: 100%;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 16px rgba(0,0,0,0.08);
    background: #fff;
  }
</style> 