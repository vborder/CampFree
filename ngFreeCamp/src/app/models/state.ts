export class State {
  id: number;
  abbr: string;
  name: string;

  constructor(id?: number, abbr?: string, name?: string) {
    this.id = id;
    this.abbr = abbr;
    this.name = name;

  }
}
