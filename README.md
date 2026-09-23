# pro-10# Linux Lab Assignment

# Creating and Activating Swap Space

## Aim

To create and activate swap space in Linux.

---

## Theory

Swap space is virtual memory used by Linux when physical RAM becomes full.

It improves system stability by allowing inactive memory pages to be stored on disk.

---

## Commands Used

```bash
sudo swapoff /swapfile
sudo rm -f /swapfile
sudo dd if=/dev/zero of=/swapfile bs=1M count=1024
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
```

---

## Instructions

1. Complete `swap.sh`.
2. Make it executable.

```bash
chmod +x swap.sh
```

3. Commit and push.

```bash
git add .
git commit -m "Completed Swap Assignment"
git push
```

---

## Expected Output

```
NAME       TYPE SIZE USED PRIO
/swapfile  file   1G   0B   -2
```

---

## Marks

| Task | Marks |
|-------|-------|
| Script correctness | 50 |
| Proper permissions | 20 |
| Swap activation | 20 |
| Code quality | 10 |
