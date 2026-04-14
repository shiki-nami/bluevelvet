# bluevelvet &nbsp; [![bluebuild 构建徽章](https://github.com/shiki-nami/bluevelvet/actions/workflows/build.yml/badge.svg)](https://github.com/shiki-nami/bluevelvet/actions/workflows/build.yml)
## 安装
要将现有的 Fedora Atomic 安装变基（rebase）到最新构建版本：
- 首先变基到未签名的镜像，以安装正确的签名密钥和策略：
```bash
rpm-ostree rebase ostree-unverified-registry:ghcr.nju.edu.cn/shiki-nami/bluevelvet:latest
```
- 重启以完成变基：
```bash
systemctl reboot
```
- 然后像这样变基到已签名的镜像：
```bash
rpm-ostree rebase ostree-image-signed:docker://ghcr.nju.edu.cn/shiki-nami/bluevelvet:latest
```
- 再次重启以完成安装：
```bash
systemctl reboot
```
`latest` 标签将自动指向最新的构建版本。该构建将始终使用 `recipe.yml` 中指定的 Fedora 版本，因此您不会意外更新到下一个主要版本。
## ISO
如果在 Fedora Atomic 上构建，您可以按照[此处](https://blue-build.org/how-to/generate-iso/#_top)提供的说明生成离线 ISO。遗憾的是，由于文件体积较大，这些 ISO 无法在 GitHub 上免费分发，因此对于公开项目，必须使用其他方式来进行托管。
## 验证
这些镜像使用 [Sigstore](https://www.sigstore.dev/) 的 [cosign](https://github.com/sigstore/cosign) 进行签名。您可以通过从本仓库下载 `cosign.pub` 文件并运行以下命令来验证签名：
```bash
cosign verify --key cosign.pub ghcr.nju.edu.cn/shiki-nami/bluevelvet
```
