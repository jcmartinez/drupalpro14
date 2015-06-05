<?php

include("quickstart.inc");

/**
 * @file
 *   Quickstart drush commands.
 *
 *   These commands are designed to be run inside the Quickstart development environment.
 */

/**
 * Simple helper function to keep all the arguments in a list.
 * @return <type>
 */
function _quickstart_arg_list() {
  return array('code'=>'code', 'database'=>'database', 'apache'=>'apache', 'dns'=>'dns', 'install'=>'install');
}

/**
 * Implements hook_drush_command()
 * @return array
 */
function quickstart_drush_command() {
  $items = array();

  $items['quickstart-create'] = array(
          'description' => "Create a development website (" . implode(', ', _quickstart_arg_list()) . ").",
          'arguments' => array(
                  'what' => 'Optional. One or more items to create: [' . implode('|', _quickstart_arg_list()) . '|all] Defaults to "all"',
          ),
          'options' => array(
                  'domain'       => 'Required (all).  Domain name of new site.  Use this to reference site with other commands.  Becomes dns, dbname, dbuser, dbpass, site-name, and kitchen-sink',
                  'dbuser'       => 'Optional (db).  Root mysql user.  Defaults to "root"',
                  'dbpassword'   => 'Optional (db).  Root mysql password.  Defaults to "drupalpro"',
                  'codepath'     => 'Optional (apache,code,install).  Path to drupal code.  Defaults to "~/websites/[domain]"',
                  'makefile'     => 'Optional (code).  Path to drupal make file.  Defaults to D7 "~/.drush/default.make"',
                  'profile'      => 'Optional (install).  Name of profile to install.  Defaults to "default" in D6, "standard" in D7',
                  'db-url'       => 'Optional (install).  DB url.  Defaults to "mysql://[domain]]:[domain]@localhost/[domain]" (replace . with _ in [domain])',
                  'db-prefix'    => 'Optional (install).  DB table prefix.  Defaults to ""',
                  'account-name' => 'Optional (install).  Name of user 1.  Defaults to "admin"',
                  'account-pass' => 'Optional (install).  Password user 1.  Defaults to "admin"',
                  'account-mail' => 'Optional (install).  Email of user 1.  Defaults to "admin@[domain]"',
                  'locale'       => 'Optional (install).  Installation profile.  Defaults to "en"',
                  'clean-url'    => 'Optional (install).  Enable clean-urls?  Defaults to "1"',
                  'site-name'    => 'Optional (install).  Site name.  Defaults to "[domain]"',
                  'site-mail'    => 'Optional (install).  Site default email.  Defaults to "info@[domain]"',
                  'sites-subdir' => 'Optional (install).  Dir in /sites folder.  Defaults to "default"',
          ),
          'examples' => array(
                  'Create D7 site in one command: setup dns, apache, create db, download d6, run installer, open in firefox' => 'drush quickstart-create --domain=example1.dev',
                  'Create D6 site' => 'drush qc --domain=example2.dev --makefile=d6.make',
                  'Only setup DNS entry (/etc/hosts)' => 'drush quickstart-create dns --domain=example.dev',
                  'Only setup apache vhost (/etc/apache2/sites-enabled/)' => 'drush quickstart-create apache --domain=example.dev --codepath=/path/to/drupal',
                  'Only setup database (mysql)' => 'drush quickstart-create database --domain=example.dev',
                  'Only download code (files)' => 'drush quickstart-create code --domain=example.dev',
                  'Only run install profile (or quick reinstall)' => 'drush quickstart-create install --domain=example.dev',
          ),
          'aliases' => array('qc'),
          'bootstrap' => DRUSH_BOOTSTRAP_DRUSH, // No bootstrap at all.
  );

  $items['quickstart-destroy'] = array(
          'description' => "Destroy a development website (" . implode(', ', _quickstart_arg_list()) . ").",
          'arguments' => array(
                  'what' => 'Optional. One or more items to destroy: [' . implode('|', _quickstart_arg_list()) . '|all] Defaults to "all"',
          ),
          'options' => array(
                  'domain' => 'Domain name to destroy.',
                  'codepath' => 'Path to drupal code.  Defaults to ~/websites/[domain]',
                  'yes'      => 'Optional. Skip confirmation',
          ),
          'examples' => array(
                  'Simplest format' => 'drush qd --domain=example.dev',
                  'Complete format' => 'drush quickstart-destroy all --domain=example.dev --codepath=/path/to/drupal',
                  'Only Remove DNS (/etc/hosts)' => 'drush quickstart-destroy dns --domain=example.dev',
                  'Only Remove Apache (/etc/apache2/sites-enabled/)' => 'drush quickstart-destroy apache --domain=example.dev',
                  'Only Drop Database (mysql db and user)' => 'drush quickstart-destroy database --domain=example.dev',
                  'Only Delete code and files (~/webistes/<domain>)' => 'drush quickstart-destroy code --domain=example.dev --codepath=/path/to/drupal',
                  'Only Reset for reinstall (~/webistes/<domain>)' => 'drush quickstart-destroy install --domain=example.dev --codepath=/path/to/drupal',
          ),
          'aliases' => array('qd'),
          'bootstrap' => DRUSH_BOOTSTRAP_DRUSH, // No bootstrap at all.
  );

  $items['quickstart-fixperms'] = array(
          'description' => "Fix permissions for a development website:
  \$ sudo chown -R :www-data <codepath>
  \$ sudo chmod -R a=,u=rwX,g=rX <codepath>
  \$ sudo find <codepath>/sites -type d -name files -exec chmod -R a=,ug=rwX '{}' \;
  \$ sudo find <codepath>/sites -type d -name files_private -exec chmod -R a=,ug=rwX '{}' \;",
          'arguments' => array(
          ),
          'options' => array(
                  'domain' => 'Domain name to fix permissions.',
                  'codepath' => 'Path to drupal code.  Defaults to ~/websites/[domain]',
          ),
          'examples' => array(
                  'Simplest format' => 'drush qf --domain=example.dev',
                  'Use different codepath' => 'drush quickstart-fixperms --domain=example.dev --codepath=/path/to/drupal',
          ),
          'aliases' => array('qf'),
          'bootstrap' => DRUSH_BOOTSTRAP_DRUSH, // No bootstrap at all.
  );
  return $items;
}

/**
 * Implementation of hook_drush_help().
 */
function quickstart_drush_help($section) {
  switch ($section) {
  }
}

/**
 * Helper function to check input parameters
 * @param  $required any parameters that are required
 * @return array  if $ret['fail'] is true, then check failed, and an error was logged.
 */
function _quickstart_params($required) {
  // check arguments
  $commands = drush_get_arguments();
  $options = drush_get_context('cli');
  $ret = array();

  // Commands

  // what steps do we take: "" -> "all" -> all our setup steps.
  if (count($commands)==1) {
    $commands = array("all");
  }
  if(array_search("all", $commands)!==false) {
    $commands = _quickstart_arg_list();
  }

  // Options

  // Domain always required
  // remove /'s
  $options['domain'] = str_replace('/', '', $options['domain']);
  if (strlen($options['domain']) > 15) {
    $ret['fail'] = true;
    drush_log("  '--domain' must be less than 16 characters long, for mysql user name to work.", 'error');
  }
  if (strlen($options['domain']) < 3) {
    $ret['fail'] = true;
    drush_log("  '--domain' must be at least 3 characters long.", 'error');
  }
  if (strpos($options['domain'], '.')===false) {
    $ret['fail'] = true;
    drush_log("  '--domain' must include a . for drupal installer to work.", 'error');
  }

  // defaults
  $defaults['domain_'] = $domain_ = str_replace('.','_',$options['domain']);
  // database
  $defaults['dbuser'] = 'root';
  $defaults['dbpassword'] = 'drupalpro';
  // apache, code, install
  $defaults['codepath'] = quickstart_fixpath("~/websites/" . $options['domain']);
  // code, install (check version)
  $defaults['makefile'] = quickstart_fixpath("default.make");
  // install
  $defaults['profile'] = 'standard';
  $defaults['db-url'] = "mysql://$domain_:$domain_@localhost/$domain_";
  $defaults['db-prefix'] = '';
  $defaults['account-name'] = 'admin';
  $defaults['account-pass'] = 'admin';
  $defaults['account-mail'] = 'admin@'.$options['domain'];
  $defaults['locale'] = 'en';
  $defaults['clean-url'] = '1';
  $defaults['site-name'] = $options['domain'];
  $defaults['site-mail'] = 'info@'.$options['domain'];
  $defaults['sites-subdir'] = 'default';

  // Merge it all together - 2nd array overwrites first.
  $ret = array_merge($ret, $commands);
  $ret = array_merge($ret, $defaults);
  $ret = array_merge($ret, $options);

  // Check required
  foreach($required as $require) {
    if (empty($ret[$require])) {
      $ret['fail'] = true;
      drush_log("  '--$require' is a required option for this command.", 'error');
    }
  }
  return $ret;
}

/**
 * Drush callbackfunction for 'drush quickstart-fixperms'.
 *
 * This function fixes permissions for a drupal site.
 *
 * @reurn true on success
 */
function drush_quickstart_fixperms() {
  $params = _quickstart_params(array('domain'));
  if (isset($params['fail'])) return drush_set_error(0, dt('Bad parameters.  Try "drush help quickstart-fixperms"'));

  $codepath = $params['codepath'];

  quickstart_shell_exec("sudo chown -R $USER:www-data $codepath");
  quickstart_shell_exec("sudo chmod -R a=,u=rwX,g=rX $codepath");
  // find directories named "files" and run chmod on them.
  quickstart_shell_exec("sudo find $codepath/sites -type d -name files -exec chmod -R a=,ug=rwX '{}' \;");
  quickstart_shell_exec("sudo find $codepath/sites -type d -name files_private -exec chmod -R a=,ug=rwX '{}' \;");
}

/**
 * Drush callbackfunction for 'drush quickstart-create'.
 *
 * This function goes step-by-step in creating the new site.
 *
 * @reurn true on success
 */
function drush_quickstart_create() {
  $params = _quickstart_params(array('domain'));
  if (isset($params['fail'])) return drush_set_error(0, dt('Bad parameters.  Try "drush help quickstart-create"'));
  $domain = $params['domain'];
  $domain_ = $params['domain_'];

  drush_log(' ', 'ok'); // add newline at top of output

  try {
    if (array_search("dns", $params)) {
      drush_log("Creating dns config (add $domain to /etc/hosts) ...", 'ok');
      quickstart_create_dns($domain, $params);
      drush_log('                                                ... done.', 'ok');
    }
    if (array_search("database", $params)) {
      drush_log("Creating database: $domain_", 'ok');
      quickstart_create_database($domain, $params);
      drush_log('                                                ... done.', 'ok');
    }
    if (array_search("code", $params)) {
      drush_log('Downloading code to ' . $params['codepath'] . ' (takes a minute, check network activity) ...', 'ok');
      quickstart_create_code($domain, $params);
      drush_log('                                                ... done.', 'ok');
    }
    if (array_search("apache", $params)) {  // apache after code to handle mkdir
      drush_log("Creating apache config (/etc/apache2/sites-enabled/$domain)", 'ok');
      quickstart_create_apache($domain, $params);
      drush_log('                                                ... done.', 'ok');
    }
    if (array_search("install", $params)) {
      drush_log('Running installer (takes a minute, check cpu activity) ...', 'ok');
      quickstart_create_install($domain, $params);
      drush_log('                                                ... done.', 'ok');
    }
  } catch (Exception $e) {
    $message = $e->getMessage();
    drush_log("Command failed: $message", "error");
    return false;
  }

  drush_log("Command completed successfully.", "success");
  return true;
}

/**
 * Drush callback function for 'drush quickstart-destroy'
 *
 * Works step-by-step to destroy the site.
 *
 * @return true on success
 */
function drush_quickstart_destroy() {
  $params = _quickstart_params(array('domain'));
  if (isset($params['fail'])) return drush_set_error(0, dt('Bad parameters.  Try "drush help quickstart-destroy"'));
  $domain = $params['domain'];

  $prompt = dt(
    'This will destroy the code, database and user, apache config, and dns config for @domain. Continue?',
    array('@domain' => $domain)
  );
  if (!drush_confirm($prompt)) {
    return drush_user_abort();
  }

  drush_log(' ', 'ok'); // add newline at top of output

  try {
    if (array_search("install", $params)) {
      drush_log('Destroying installation (nothing to do) ...', 'ok');
      // quickstart_destroy_install($domain, $params);
      drush_log('                                        ... done.', 'ok');
    }
    if (array_search("code", $params)) {
      drush_log('Destroying code at ' . $params['codepath'] . ' ...', 'ok');
      quickstart_destroy_code($domain, $params);
      drush_log('                                        ... done.', 'ok');
    }
    if (array_search("database", $params)) {
      drush_log('Destroying database and user ' . $params['domain_'] . ' ...', 'ok');
      quickstart_destroy_database($domain, $params);
      drush_log('                                        ... done.', 'ok');
    }
    if (array_search("apache", $params)) {
      drush_log("Destroying apache config (/etc/apache2/sites-enabled/$domain) ...", 'ok');
      quickstart_destroy_apache($domain, $params);
      drush_log('                                        ... done.', 'ok');
    }
    if (array_search("dns", $params)) {
      drush_log("Destroying dns config (remove $domain from /etc/hosts) ...", 'ok');
      quickstart_destroy_dns($domain, $params);
      drush_log('                                        ... done.', 'ok');
    }
  } catch (Exception $e) {
    $message = $e->getMessage();
    drush_log("Command failed: $message", "error");
    return false;
  }

  drush_log("Command completed successfully.", "success");
  return true;
}

