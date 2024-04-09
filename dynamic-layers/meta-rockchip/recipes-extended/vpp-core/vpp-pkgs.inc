PACKAGES += " ${PN}-papi"

FILES:${PN}-papi = " \
		${libdir}/python*/* \
		"

FILES:${PN} = " \
		${sysconfdir}/vpp \
		${sysconfdir}/vpp/startup.conf \
		${sysconfdir}/vpp/startup.conf.dflt \
		${sysconfdir}/rc.local \
		${sysconfdir}/sysctl.d \
		${sysconfdir}/sysctl.d/80-vpp.conf \
		${bindir}/* \
		${datadir}/vpp/*.py \
		${libdir}/lib*.so.${PV} \
		"

FILES:${PN}-dev = " \
		${includedir}/* \
		${libdir}/cmake/* \
		${libdir}/lib*.so \
		"

INSANE_SKIP:vpp-vat2-plugin-vnet-dev += "dev-elf"

python populate_packages:prepend () {
    # vpp core api data
    vpp_api_data_dir = d.expand('${datadir}/vpp/api/core')
    do_split_packages(d, vpp_api_data_dir, '^(.*).api.json$',
                     'vpp-core-api-data-%s', 'vpp core api data for %s',
                      extra_depends='')
    # vpp plugins
    vpp_plugin_dir = d.expand('${libdir}/vpp_plugins')
    do_split_packages(d, vpp_plugin_dir, '^(.*)_plugin.so$',
                     'vpp-plugin-%s', 'vpp plugin for %s',
                      extra_depends='')
    # vpp plugins data
    vpp_plugin_data_dir = d.expand('${datadir}/vpp/api/plugins')
    do_split_packages(d, vpp_plugin_data_dir, '^(.*).api.json$',
                     'vpp-plugin-data-%s', 'vpp plugin data for %s',
                      extra_depends='')
    # vat2 plugins
    vat2_plugin_dir = d.expand('${libdir}/vat2_plugins')
    do_split_packages(d, vat2_plugin_dir, '^(.*)_plugin.so$',
                     'vpp-vat2-plugin-%s', 'vpp vat2 plugin for %s',
                      extra_depends='')
    # test plugins
    test_plugin_dir = d.expand('${libdir}/vpp_api_test_plugins')
    do_split_packages(d, test_plugin_dir, '^(.*)_test_plugin.so$',
                     'vpp-test-plugin-%s', 'vpp test plugin for %s',
                      extra_depends='')
}