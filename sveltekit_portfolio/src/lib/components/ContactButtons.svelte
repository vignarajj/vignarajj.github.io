<script lang="ts">
  import ContactButton from './ContactButton.svelte';
  export let githubUrl: string = 'https://github.com/vignarajj';
  export let mediumUrl: string = 'https://medium.com/@vignarajj';
  export let linkedinUrl: string = 'https://www.linkedin.com/in/vignaraj-ravi-25750b59/';
  export let githubIcon: string = '/src/lib/assets/images/github.png';
  export let mediumIcon: string = '/src/lib/assets/images/medium.png';
  export let linkedinIcon: string = '/src/lib/assets/images/linkedin.png';
</script>

<div class="contact-buttons">
  <ContactButton icon={githubIcon} url={githubUrl} label="GitHub" />
  <ContactButton icon={mediumIcon} url={mediumUrl} label="Medium" />
  <ContactButton icon={linkedinIcon} url={linkedinUrl} label="LinkedIn" />
</div>

<style>
  .contact-buttons {
    display: flex;
    gap: 1.5rem;
    justify-content: center;
    align-items: center;
    margin: 1.5rem 0;
  }
</style> 