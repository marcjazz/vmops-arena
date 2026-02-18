
#!/bin/bash

echo "--- VALIDATION REPORT ---"
echo "Generated on: $(date)"

# 1. User Check
if id "student" &>/dev/null; then
    echo "[PASS] User 'student' exists."
else
    echo "[FAIL] User 'student' missing."
fi

# 2. Shell Check
if [ "$(getent passwd student | cut -d: -f7)" == "/bin/zsh" ]; then
    echo "[PASS] Shell for 'student' is /bin/zsh."
else
    echo "[FAIL] Shell is $(getent passwd student | cut -d: -f7)."
fi

# 3. Oh My Zsh Check
if [ -d "/home/student/.oh-my-zsh" ]; then
    echo "[PASS] Oh My Zsh is installed."
else
    echo "[FAIL] Oh My Zsh directory missing."
fi

# 4. SSH Hardening Check
if grep -q "PasswordAuthentication no" /etc/ssh/sshd_config; then
    echo "[PASS] SSH Password Authentication disabled."
else
    echo "[FAIL] SSH Password Authentication still enabled."
fi

if grep -q "PermitRootLogin no" /etc/ssh/sshd_config; then
    echo "[PASS] SSH Root Login disabled."
else
    echo "[FAIL] SSH Root Login allowed."
fi

# 5. UFW Check
if ufw status | grep -q "active"; then
    echo "[PASS] UFW is active."
    if ufw status | grep -q "22/tcp" && ufw status | grep -q "80/tcp"; then
        echo "[PASS] Firewall rules for 22 and 80 are present."
    else
        echo "[FAIL] Required firewall rules missing."
    fi
else
    echo "[FAIL] UFW is inactive."
fi

# 6. Network Check
if ip addr show | grep -q "192.168.56.10"; then
    echo "[PASS] Private IP 192.168.56.10 is configured."
else
    echo "[FAIL] Private IP 192.168.56.10 not found."
fi

echo "--- END OF REPORT ---"