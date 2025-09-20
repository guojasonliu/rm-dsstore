Name:           rm-dsstore
Version:        1.0.0
Release:        1%{?dist}
Summary:        Recursively delete macOS .DS_Store files
License:        MIT
URL:            https://github.com/<your-username>/rm-dsstore
BuildArch:      noarch

%description
A tiny utility to remove .DS_Store files from a directory tree.

%prep
# nothing

%build
# nothing

%install
mkdir -p %{buildroot}/usr/local/bin
install -m 0755 bin/rm-dsstore %{buildroot}/usr/local/bin/rm-dsstore

%files
/usr/local/bin/rm-dsstore

%changelog
* Fri Sep 19 2025 Your Name <you@example.com> - 1.0.0-1
- Initial package
