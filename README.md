# Kafka 0.7.x Cookbook #

This downloads and compiles either the 0.7.1 or 0.7.2 versions of
[Apache Kafka][1]. The latest version of Kafka is 0.8.x, but since they
changed the wire protocol, some drivers aren't yet capable.

* This cookbook does not have any explicit dependencies, but java must
  be available.
* Uses upstart for service management.
* Zookeeper is not bundled.

A hearty shoutout to the following repos, from which much of this was
inspired/stolen:

* https://github.com/Webtrends/kafka
* https://github.com/mthssdrbrg/kafka-cookbook
* https://github.com/rkrol/chef-kafka

[1]: http://kafka.apache.org/
