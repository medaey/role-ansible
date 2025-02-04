<!-- DOCSIBLE START -->

# 📃 Role overview

## my_tools



Description: your role description


| Field                | Value           |
|--------------------- |-----------------|
| Readme update        | 04/02/2025 |












### Tasks


#### File: tasks/setup-Alpine-3.19.yml

| Name | Module | Has Conditions |
| ---- | ------ | --------- |
| Installation des PAQUETS | community.general.apk | True |

#### File: tasks/setup-Alpine-3.20.yml

| Name | Module | Has Conditions |
| ---- | ------ | --------- |
| Installation des PAQUETS | community.general.apk | True |

#### File: tasks/setup-Debian-12.yml

| Name | Module | Has Conditions |
| ---- | ------ | --------- |
| Installation des PAQUETS | ansible.builtin.apt | True |

#### File: tasks/setup-Alpine-3.18.yml

| Name | Module | Has Conditions |
| ---- | ------ | --------- |
| Installation des PAQUETS | community.general.apk | True |

#### File: tasks/main.yml

| Name | Module | Has Conditions |
| ---- | ------ | --------- |
| Afficher la famille du système d'exploitation et la version majeure | debug | False |
| Inclure les tâches spécifiques pour les versions majeures de Debian | include_tasks | True |
| Inclure les tâches spécifiques pour les versions majeures d'Alpine | include_tasks | True |


## Task Flow Graphs



### Graph for setup-Alpine-3.19.yml

```mermaid
flowchart TD
Start
classDef block stroke:#3498db,stroke-width:2px;
classDef task stroke:#4b76bb,stroke-width:2px;
classDef includeTasks stroke:#16a085,stroke-width:2px;
classDef importTasks stroke:#34495e,stroke-width:2px;
classDef includeRole stroke:#2980b9,stroke-width:2px;
classDef importRole stroke:#699ba7,stroke-width:2px;
classDef includeVars stroke:#8e44ad,stroke-width:2px;
classDef rescue stroke:#665352,stroke-width:2px;

  Start-->|Task| Installation_des_PAQUETS0[installation des paquets<br>When: **ansible distribution     alpine**]:::task
  Installation_des_PAQUETS0-->End
```


### Graph for setup-Alpine-3.20.yml

```mermaid
flowchart TD
Start
classDef block stroke:#3498db,stroke-width:2px;
classDef task stroke:#4b76bb,stroke-width:2px;
classDef includeTasks stroke:#16a085,stroke-width:2px;
classDef importTasks stroke:#34495e,stroke-width:2px;
classDef includeRole stroke:#2980b9,stroke-width:2px;
classDef importRole stroke:#699ba7,stroke-width:2px;
classDef includeVars stroke:#8e44ad,stroke-width:2px;
classDef rescue stroke:#665352,stroke-width:2px;

  Start-->|Task| Installation_des_PAQUETS0[installation des paquets<br>When: **ansible distribution     alpine**]:::task
  Installation_des_PAQUETS0-->End
```


### Graph for setup-Debian-12.yml

```mermaid
flowchart TD
Start
classDef block stroke:#3498db,stroke-width:2px;
classDef task stroke:#4b76bb,stroke-width:2px;
classDef includeTasks stroke:#16a085,stroke-width:2px;
classDef importTasks stroke:#34495e,stroke-width:2px;
classDef includeRole stroke:#2980b9,stroke-width:2px;
classDef importRole stroke:#699ba7,stroke-width:2px;
classDef includeVars stroke:#8e44ad,stroke-width:2px;
classDef rescue stroke:#665352,stroke-width:2px;

  Start-->|Task| Installation_des_PAQUETS0[installation des paquets<br>When: **ansible distribution     debian**]:::task
  Installation_des_PAQUETS0-->End
```


### Graph for setup-Alpine-3.18.yml

```mermaid
flowchart TD
Start
classDef block stroke:#3498db,stroke-width:2px;
classDef task stroke:#4b76bb,stroke-width:2px;
classDef includeTasks stroke:#16a085,stroke-width:2px;
classDef importTasks stroke:#34495e,stroke-width:2px;
classDef includeRole stroke:#2980b9,stroke-width:2px;
classDef importRole stroke:#699ba7,stroke-width:2px;
classDef includeVars stroke:#8e44ad,stroke-width:2px;
classDef rescue stroke:#665352,stroke-width:2px;

  Start-->|Task| Installation_des_PAQUETS0[installation des paquets<br>When: **ansible distribution     alpine**]:::task
  Installation_des_PAQUETS0-->End
```


### Graph for main.yml

```mermaid
flowchart TD
Start
classDef block stroke:#3498db,stroke-width:2px;
classDef task stroke:#4b76bb,stroke-width:2px;
classDef includeTasks stroke:#16a085,stroke-width:2px;
classDef importTasks stroke:#34495e,stroke-width:2px;
classDef includeRole stroke:#2980b9,stroke-width:2px;
classDef importRole stroke:#699ba7,stroke-width:2px;
classDef includeVars stroke:#8e44ad,stroke-width:2px;
classDef rescue stroke:#665352,stroke-width:2px;

  Start-->|Task| Afficher_la_famille_du_système_d_exploitation_et_la_version_majeure0[afficher la famille du système d exploitation et<br>la version majeure]:::task
  Afficher_la_famille_du_système_d_exploitation_et_la_version_majeure0-->|Include task| setup_Debian____ansible_distribution_version_split______0_____yml1[inclure les tâches spécifiques pour les versions<br>majeures de debian<br>When: **ansible distribution     debian**<br>include_task: setup debian    ansible distribution version split<br>     0     yml]:::includeTasks
  setup_Debian____ansible_distribution_version_split______0_____yml1-->|Include task| setup_Alpine____ansible_distribution_version_split_______2____join_________yml2[inclure les tâches spécifiques pour les versions<br>majeures d alpine<br>When: **ansible distribution     alpine**<br>include_task: setup alpine    ansible distribution version split<br>      2    join         yml]:::includeTasks
  setup_Alpine____ansible_distribution_version_split_______2____join_________yml2-->End
```


## Playbook

```yml
# playbooks/my_tools.yml
---
- name: Installer des outils système
  hosts: my_tools  # Ou spécifiez les hôtes ou les groupes d'hôtes cibles
  become: yes  # Si nécessaire
  roles:
    - my_tools

```
## Playbook graph
```mermaid
flowchart TD
  my_tools-->|Role| my_tools[my tools]
```

## Author Information
your name

#### License

license (GPL-2.0-or-later, MIT, etc)

#### Minimum Ansible Version

2.1

#### Platforms

No platforms specified.
<!-- DOCSIBLE END -->