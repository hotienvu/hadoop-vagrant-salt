{% from 'java/settings.sls' import java with context %}
python-software-properties:
  pkg.installed

oracle-ppa:
  pkgrepo.managed:
    - humanname: WebUpd8 Oracle Java PPA repository
    - ppa: webupd8team/java

oracle-licenese-select:
  cmd.run:
    - unless: which java
    - name: '/bin/echo oracle-java-7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections'
    - require_in: oracle-java7-installer

oracle-java7-installer:
  pkg.installed:
    - skip_verify: Yes
    - require:
      - pkgrepo: oracle-ppa

jvm_home:
  file.directory:
    - name: {{ java.jvm_home }}
    - dir_mode: 0755
    - makedirs: True

java_home:
  file.symlink:
    - name: {{ java.java_home }}
    - target: {{ java.current_java_home }}
    - require:
      - file: jvm_home

java_env:
  file.managed:
    - name: {{ java.java_profile_d }}
    - source: salt://java/java.sh
    - template: jinja
    - mode: 644
    - group: root
    - user: root
    - context:
      java_home: {{ java.java_home }}
    - require:
      - file: java_home
