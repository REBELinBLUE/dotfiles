// @ts-check

/**
 * @typedef {import('/Applications/Finicky.app/Contents/Resources/finicky.d.ts')} Globals
 * @typedef {import('/Applications/Finicky.app/Contents/Resources/finicky.d.ts').FinickyConfig} FinickyConfig
 */

/**
 * @type {FinickyConfig}
 */
export default {
  defaultBrowser: "Safari",
  options: {
    checkForUpdates: true,
    logRequests: false,
  },
  // rewrite: [
  //   {
  //     match: () => true,
  //     url: ({url}) => {
  //         const removeKeysStartingWith = ["utm_", "uta_"]; // Remove all query parameters beginning with these strings
  //         const removeKeys = ["fbclid", "gclid"]; // Remove all query parameters matching these keys

  //         const search = url.search
  //             .split("&")
  //             .map((parameter) => parameter.split("="))
  //             .filter(([key]) => !removeKeysStartingWith.some((startingWith) => key.startsWith(startingWith)))
  //             .filter(([key]) => !removeKeys.some((removeKey) => key === removeKey));

  //         return {
  //             ...url,
  //             search: search.map((parameter) => parameter.join("=")).join("&"),
  //         };
  //     },
  //   },
  // ],
  handlers: [
    {
      match: (url, options) => options.opener?.bundleId === "com.1password.1password",
      browser: "Safari"
    },
    {
      match: (url, options) => {
        if (options.opener?.bundleId == "com.bluebanana-software.inyourface") {
            return url.host.includes("google.com")
        }

        // FIXME: Second part of this seems wrong, where did it come from? it breaks sign in with google in most apps
        return url.host.startsWith("meet.google.com") //|| url.host.startsWith("accounts.google.com")
      },
      browser: (url) => ({
        name: "Google Chrome",
        // args: [
        //     '--app-id=kjgfgldnnfoeklkmfkjfagphfepbbdan',
        //     `--app-launch-url-for-shortcuts-menu-item=${url.toString()}`,
        // ]
      })
    },
    {
      match: /^https?:\/\/www.google.com\/calendar\/event.*$/,
      browser: "Google Chrome"
    },
    {
      match: /^https?:\/\/(accounts|docs|sheets|slides|mail|drive|calendar|groups|admin)\.google\.com.*$/,
      browser: "Google Chrome"
    },
    {
      match: /^https?:\/\/tel\.meet.*$/,
      browser: "Google Chrome"
    },
    {
      match: /^https?:\/\/forms\.gle.*$/,
      browser: "Google Chrome"
    },
    {
      match: /^https?:\/\/.*\.logicgate\.com.*$/,
      browser: "Google Chrome"
    }
  ]
}