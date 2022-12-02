hkex-admin
hkex-leader
hkex-developer
hkex-qa-engineer

oc login -u hkex-admin -p nopass https://api.hkexpoc.redhathk.com:6443

oc get clusterrolebinding -o wide \
    | grep -E 'NAME|self-provisioner'

oc describe clusterrolebindings self-provisioners

oc adm policy remove-cluster-role-from-group  \
    self-provisioner system:authenticated:oauth

oc describe clusterrolebindings self-provisioners

oc get clusterrolebinding -o wide \
    | grep -E 'NAME|self-provisioner'

oc login -u hkex-leader -p nopass

oc new-project hkex-test

oc login -u hkex-admin -p nopass

oc new-project authorization-rbac

oc policy add-role-to-user admin hkex-leader -n authorization-rbac

oc adm groups new dev-group

oc adm groups add-users dev-group hkex-developer

oc adm groups new qa-group

oc adm groups add-users qa-group hkex-qa-engineer

oc get groups

oc login -u hkex-leader -p nopass

oc policy add-role-to-group edit dev-group -n authorization-rbac

oc policy add-role-to-group view qa-group -n authorization-rbac

oc get rolebindings -o wide

oc login -u hkex-developer -p developer

oc new-app --name httpd httpd:2.4 -n authorization-rbac

oc policy add-role-to-user edit hkex-qa-engineer

oc login -u qa-engineer -p nopass

oc scale deployment httpd --replicas 3

oc login -u hkex-admin -p nopass

oc adm policy add-cluster-role-to-group \
  --rolebinding-name self-provisioners \
  self-provisioner system:authenticated:oauth

