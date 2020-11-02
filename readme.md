# The Globe Church

Site running on CraftCMS.

Sprinkled with Tailwind.

## Setup

```bash
cp .env.example .env
```

Edit the `.env` file as required

```bash
composer install
npm install && npm run dev
```

### With Laravel Valet

```bash
valet link globe
valet secure globe
```

## Provisioning and Deploying

### Provision

There is an [Ansible Playbook](https://docs.ansible.com/) to provision (`ansbile/provision.yml`) the server. This relies on:

- The host `do-globe` to be set in your `.ssh_config` file to match the `hosts` file at the root of this repo
- A `vaultPass.cnf' containing the string of the Ansible Vault password at the root of this repo (don't commit that file, that would be silly).

Once set correctly, you can provision a Ubuntu server. the secrets in the vault will automagically be used to set things like the database password, access to DO spaces, etc.

Provision with:

```bash
ansible-playbook ansible/provision.yml
```

### Deploy

Same as above

```bash
ansible-playbook ansible/deploy.yml
```

### Updating the vault

```bash
ansible-vault edit ansible/group_vars/all/vault.yml
```

As per [best practice](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html#keep-vaulted-variables-safely-visible) secrets in the vault should be accessed through the main `vars.yml` file, rather than directly.
