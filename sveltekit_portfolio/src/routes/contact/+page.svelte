<script lang="ts">
  import { contactForm, contactSubmitting, contactResult } from '$lib/stores/contact.store';
  import AnimatedSection from '$lib/components/AnimatedSection.svelte';
  import { sendContactForm } from '$lib/api/contact';
  import { get } from 'svelte/store';

  let name = '';
  let email = '';
  let phone = '';
  let message = '';
  let error = '';

  function validate() {
    if (!name || !email || !message) {
      error = 'Name, email, and message are required.';
      return false;
    }
    error = '';
    return true;
  }

  async function submitForm() {
    if (!validate()) return;
    contactSubmitting.set(true);
    contactForm.set({ name, email, phone, message });
    const res = await sendContactForm({ name, email, phone, message });
    contactSubmitting.set(false);
    if (res.success) {
      contactResult.set(res.message || 'Thank you for reaching out!');
      name = email = phone = message = '';
    } else {
      error = res.message || 'Failed to send message.';
    }
  }
</script>

<section class="contact-section">
  <h1>Contact</h1>
  <AnimatedSection>
    <form class="contact-form" on:submit|preventDefault={submitForm}>
      <input type="text" placeholder="Name" bind:value={name} required />
      <input type="email" placeholder="Email" bind:value={email} required />
      <input type="tel" placeholder="Phone" bind:value={phone} />
      <textarea placeholder="Message" bind:value={message} required rows="5"></textarea>
      {#if error}
        <div class="error">{error}</div>
      {/if}
      <button type="submit" class="submit-btn" disabled={$contactSubmitting}>
        {#if $contactSubmitting}Sending...{:else}Send{/if}
      </button>
      {#if $contactResult}
        <div class="result">{$contactResult}</div>
      {/if}
    </form>
  </AnimatedSection>
</section>

<style>
  .contact-section {
    max-width: 600px;
    margin: 0 auto;
    padding: 2rem 1rem;
    text-align: center;
  }
  .contact-form {
    display: flex;
    flex-direction: column;
    gap: 1rem;
    background: #23272f;
    border-radius: 16px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.08);
    padding: 2rem 1.5rem;
    color: #fff;
  }
  input, textarea {
    border-radius: 8px;
    border: 1px solid #6c63ff;
    padding: 0.7rem 1rem;
    font-size: 1rem;
    outline: none;
    background: #181a20;
    color: #fff;
  }
  .submit-btn {
    background: #6c63ff;
    color: #fff;
    border: none;
    border-radius: 8px;
    padding: 0.7rem 1.5rem;
    font-size: 1rem;
    cursor: pointer;
    transition: background 0.2s;
  }
  .submit-btn:disabled {
    background: #444;
    cursor: not-allowed;
  }
  .error {
    color: #ff6b6b;
    font-size: 0.95rem;
    margin-bottom: 0.5rem;
  }
  .result {
    color: #6c63ff;
    font-size: 1.1rem;
    margin-top: 1rem;
  }
  h1 {
    font-size: 2.2rem;
    margin-bottom: 1.5rem;
    color: #6c63ff;
  }
</style> 