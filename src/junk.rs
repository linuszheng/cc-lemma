
let ty = match self.local_context.get(&v) {
  Some(ty) => ty,
  None => panic!("{} not in local context", v),
};
// Convert to datatype name
let dt = Symbol::from(ty.datatype().unwrap().0);
// Get the constructors of the datatype
let (_, cons) = self.global_search_state.env.get(&dt).unwrap_or_else(|| {
  println!("unexpected datatype {} for variable {}", dt, v);
  println!("params: {:?}, prop: {}", self.top_level_params, self.eq);
  panic!()
});
let mut f_exprs = vec![];
for con in cons {
  let con_args = self.instantiate_constructor(&con, ty);
  let n_args = con_args.len();
  let con_args_concrete: Vec<String> = (0..n_args).map(|i| format!("?v{}", i)).collect();
  for (i, con_arg) in con_args.into_iter().enumerate().filter(|(i, c)| c == ty) {
    let mut con_args_concrete_with_var = con_args_concrete.clone();
    con_args_concrete_with_var[i] = v.to_string();
    let searcher: Pattern<SymbolLang> =
      format!("({} {})", con, con_args_concrete_with_var.join(" "))
        .parse()
        .unwrap();
    self.egraph.rebuild();
    let match_ids: Vec<Id> = searcher
      .search(&self.egraph)
      .into_iter()
      .map(|x| x.eclass)
      .collect();
    // lhs
    for gen_id in match_ids {
      let fresh_var = format!("fresh_{}_{}", self.name, self.egraph.total_size());
      let fresh_symb = Symbol::from(&fresh_var);
      let f_expr = self.extract_generalized_expr(gen_id, fresh_symb, lhs_id);
      println!("f expr: {}", f_expr.clone());
      f_exprs.push(f_expr);
    }
  }
}