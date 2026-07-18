import type { ReactNode } from 'react';
export function Panel({ title, subtitle, children, actions }: {title:string; subtitle?:string; children:ReactNode; actions?:ReactNode}) {
  return <section className="panel">
    <header className="panel-header"><div><h2>{title}</h2>{subtitle && <p>{subtitle}</p>}</div>{actions}</header>
    <div className="panel-body">{children}</div>
  </section>;
}
