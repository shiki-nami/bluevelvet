bluevelvet   
请参阅 BlueBuild 文档，获取基于此模板创建自定义镜像仓库的快速设置说明。
完成设置后，建议更新此 README 以描述你的自定义镜像。

安装
[!WARNING]
这是一项实验性功能，请谨慎使用。
将现有的 Fedora Atomic 安装变基到最新构建：
第一步，变基到未签名镜像，以安装正确的签名密钥和策略：

rpm-ostree rebase ostree-unverified-registry:ghcr.io/shiki-nami/bluevelvet:latest


第二步，重启以完成变基：

systemctl reboot


第三步，变基到已签名镜像：

rpm-ostree rebase ostree-image-signed:docker://ghcr.io/shiki-nami/bluevelvet:latest


第四步，再次重启以完成安装：

systemctl reboot


latest 标签将自动指向最新构建。该构建始终使用 recipe.yml 中指定的 Fedora 版本，不会意外升级到下一个主要版本。

ISO
如果在 Fedora Atomic 上构建，可按照此处的说明生成离线 ISO。由于文件体积较大，这些 ISO 无法免费分发到 GitHub，公开项目需使用其他方式托管。

验证
这些镜像使用 Sigstore 的 cosign 进行签名。从本仓库下载 cosign.pub 文件后，运行以下命令验证签名：

cosign verify --key cosign.pub ghcr.io/shiki-nami/bluevelvet