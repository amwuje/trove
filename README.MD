# **KVM自动部署ansible-playbook脚本**

支持 Redhat、centos、openEuler操作系统

## 使用说明

### 修改配置

inventory/all.yml文件样例如下，我们需要修改其中一部分配置：

```yaml
        mc_redhat:
            hosts:
                litecore_mc0_redhat:
                    ansible_host: '2023:2:2:1::30a'
                    ansible_host_eth1_v4: '192.168.9.113'
                    ansible_host_eth1_v6: '3333:6666:8888:600:11:10:229:113'
                    hostname: 'dev-lcnms_mc_redhat_in_0'
                    vcpu: 4
                    vmemory: 8388608   #kib
                    vdb: 20
                    vdc: 20
                    vdd: 60
                    node_id: 0
                litecore_mc1_redhat:
                    ansible_host: '2023:2:2:1::30b'
                    ansible_host_eth1_v4: '192.168.9.113'
                    ansible_host_eth1_v6: '3333:6666:8888:600:11:10:229:113'
                    hostname: 'dev-lcnms_mc_redhat_in_1'
                    vcpu: 4
                    vmemory: 8388608   #kib
                    vdb: 20
                    vdc: 20
                    vdd: 60
                    node_id: 1
                #litecore_mc2_redhat:
                #    ansible_host: '2023:2:2:1::30c'
                #    ansible_host_eth1_v4: '192.168.9.113'
                #    ansible_host_eth1_v6: '3333:6666:8888:600:11:10:229:113'
                #    hostname: 'dev-lcnms_mc_redhat_in_2'
                #    node_id: 2
    vars:
        ansible_port: 22
        ansible_user: root
        ansible_password: "-abc0mN&MS"
        ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
        kvm_clone_from:
            acm_vm_name: "litecore_acm_image_redhat8.6_v01"
            db_vm_name: "litecore_db_image_redhat8.6_v01"
            default_vm_ip: "172.28.30.236"
            # acm_vm_name: "vn7ms_acm_image_openeuler21.03_v06"
            # db_vm_name: "vn7ms_db_image_openeuler21.03_v06"
            # default_vm_ip: "192.168.9.98"
            # acm_vm_name: "vn7ms_acm_image_c2009_v19"
            # db_vm_name: "vn7ms_db_image_c2009_v19"
            # default_vm_ip: "192.168.9.91"
        default_sleep_timeout: 10 #seconds
        eth0_alias: 'eth0'
        eth1_alias: 'eth1'
        eth1_mask: '255.255.255.240'
        eth1_gtwy: '172.28.30.225'
        local_dns_ip: '172.28.30.225'
        vn7ms_env:
            DB_DATABASE: vn7ms
            DB_USERNAME: n7ms
            DB_PASSWORD: '-abc0mN&MS'
```

根据规划修改配置

### 执行升级

执行如下命令：

```shell
ansible-playbook -i init_vn7ms_local_vms_centos.yml -v   ##guest是Centos系统主机
ansible-playbook -i init_vn7ms_local_vms_redhat.yml -v   ##guest是Redhat系统主机
ansible-playbook -i init_vn7ms_local_vms_oel.yml -v      ##guest是Euler系统主机
```

如果执行成功，一般会得到类似如下的报告：

```sh
PLAY RECAP ********************************************************************************************************************************************************************************************
test_host1                 : ok=19   changed=13   unreachable=0    failed=0    skipped=0    rescued=0    ignored=1   
test_host2                 : ok=19   changed=13   unreachable=0    failed=0    skipped=0    rescued=0    ignored=1   
```