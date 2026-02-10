# DevOps Lab: Vagrant + Cloud-Init + CI

![CI](https://github.com/marcjazz/vmops-arena/actions/workflows/validate.yml/badge.svg)


## 🎯 Objective

Create a reproducible development VM using:

- Vagrant
- cloud-init
- SSH key injection
- Zsh + Oh My Zsh

Your submission must pass CI validation.

---

## 📌 Requirements

Your VM must:

1. Create a user named `student`
2. Set default shell to `/bin/zsh`
3. Install:
   - zsh
   - git
   - curl
4. Install Oh My Zsh (unattended)
5. Inject your SSH public key
6. Boot successfully using:

```

vagrant up

```

---

## 🛠 How to Work

1. Fork this repository
2. Edit:

- `cloud-init/user-data.yaml`
- `Vagrantfile`

3. Test locally:

```

vagrant up

```

4. Push your changes
5. Open a Pull Request

CI will automatically grade your work.

---

## 🧪 Local Validation Commands

vagrant up
vagrant ssh
getent passwd student
echo $SHELL
ls -la ~/.oh-my-zsh

---

## 🏆 Grading

| Criteria            | Points |
| ------------------- | ------ |
| student user exists | 25     |
| zsh installed       | 25     |
| Oh My Zsh installed | 25     |
| SSH key configured  | 25     |

Passing score: **70/100**

---

Good luck.
Infrastructure is code.
