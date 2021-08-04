declare namespace Sandbox {
  type RequestHandler = (request: any, response: any) => any;
  function define(path: string, method: string, handler: RequestHandler);
}
