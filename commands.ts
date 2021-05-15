export const commands: Map<string, Array<string>> = new Map<
  string,
  Array<string>
>([
  ['init', ['name', 'license', 'author']],
]);

/**
 * @param command The command to execute
 * @param params The params passed in
 */
export const performCommand = (
  command: string,
  params: Map<string, string>,
  cli: Array<string>
) => {
 
};