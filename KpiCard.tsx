import type { ReactNode } from 'react';

type Props = { label: string; value: string | number; hint?: string; icon?: ReactNode };
export function KpiCard({ label, value, hint, icon }: Props) {
  return <article className="kpi-card">
    <div className="kpi-icon">{icon}</div>
    <div><div className="kpi-label">{label}</div><div className="kpi-value">{value}</div>{hint && <div className="kpi-hint">{hint}</div>}</div>
  </article>;
}
