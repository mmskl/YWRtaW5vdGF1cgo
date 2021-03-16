Run

```
./setup.sh
ansible-playbook -i inventory.cfg playbook.yml
./test.sh
```

* ./setup.sh - creates base debian 10 image with running ssh
* ./test.sh - runs a few basic tests to check if everything works correctly
