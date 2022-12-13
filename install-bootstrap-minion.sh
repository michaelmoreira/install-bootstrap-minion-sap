#!/usr/bin/env python

import os

# Verifica se o pacote SAP está instalado
if os.system("rpm -qa | grep -q '^sap-'") == 0:
  # Obtém a versão do SAP instalada
  sap_version = os.system("rpm -qa | grep '^sap-' | sed -E 's/^sap-(.+)-[0-9].+/\\1/'")
  # Instala o bootstrap minion na versão do SAP
  os.system("zypper install salt-minion-sap-bootstrap-%s" % sap_version)
else:
  # Obtém a versão do sistema operacional
  with open("/etc/os-release") as f:
    for line in f:
      if line.startswith("VERSION_ID"):
        os_version = line.split("=")[1].strip().strip('"')
        break
  # Instala o bootstrap minion na versão do sistema operacional
  os.system("zypper install salt-minion-sles-bootstrap-%s" % os_version)
