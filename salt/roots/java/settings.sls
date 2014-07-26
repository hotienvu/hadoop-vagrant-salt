{% set jvm_home = '/usr/lib/jvm' %}
{% set java_home = jvm_home + '/java-default' %}
{% set current_java_home = jvm_home + '/java-7-oracle' %}
{% set java_profile_d = '/etc/profile.d/java.sh' %}

{% set java = {
    'jvm_home': jvm_home,
    'java_home': java_home,
    'current_java_home': current_java_home,
    'java_profile_d': java_profile_d
  }
%}
